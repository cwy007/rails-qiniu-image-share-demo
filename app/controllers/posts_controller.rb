class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @qiniu_upload_token = generate_qiniu_upload_token
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    upload_ret = JSON.parse(Base64.urlsafe_decode64(params[:upload_ret]))
    @post = Post.new(
      title: upload_ret['title'],
      filename: upload_ret['fname'],
      qiniu_hash: upload_ret['hash']
    )

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :filename, :qiniu_hash)
    end

    def generate_qiniu_upload_token
      put_policy = Qiniu::Auth::PutPolicy.new('konata')
      put_policy.return_body = {
        fname: '$(fname)',
        hash: '$(etag)',
        title: '$(x:title)'
      }.to_json
      put_policy.return_url = create_posts_url
      Qiniu::Auth.generate_uptoken(put_policy)
    end
end
