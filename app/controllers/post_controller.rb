class PostController < ApplicationController
  def index
  render json: Posts.includes(:files).as_json(include: :files)
  end

  def create
  	post = Posts.create({
  		title: params[:title],
  		permalink: params[:permalink],
  		content: params[:content],
  		users_id: 1
  	})

    if params[:form].present?
      image = params[:form][:file]
      _fileUpload(image)
  
      file = Files.create({
        original_filename: @name,
        filepath: 'upload/' + @hash_value,
        filename: @hash_value,
        mimetype: image.content_type,
        posts_id: post[:id]
      })
    end

  	render json: post
  end

  def update
    post = Posts.find params[:id]

    if post.present?
      post.update({
        title: params[:title],
        permalink: params[:permalink],
        content: params[:content]
      })

      if params[:form].present?
        image = params[:form][:file]
        file_exist = Files.where(posts_id: post[:id]).first
        if file_exist.present?
          path = Rails.root + file_exist.filepath

          file_exist.destroy

          # physical delete file 
          File.delete(path) if File.exist?(path)
        end

        _fileUpload(image)

        file = Files.create({
          original_filename: @name,
          filepath: 'upload/' + @hash_value,
          filename: @hash_value,
          mimetype: image.content_type,
          posts_id: post[:id]
        })
      end
    end

    render json: post
  end

  def destroy
    post = Posts.find params[:id]
    post.destroy()

    render json: post
  end

  def display_all 
    @class = 'post-page'
  end

  def image
    if Files.exists? id: params[:id]
      # get file
      @image = Files.find params[:id]

      path = Rails.root + @image.filepath
      
      # read content of the file
      data = File.open(path, 'rb') {|file| file.read }
      
      # set Content type of the file
      response.headers["Content-Type"] = @image.mimetype
      
      # print file content
      render :text => data
      return false
    else
      render :text => 'We Cant Find your file.', :status => '404'
    end
  end

  private
  def _fileUpload(file)
    @dir = Rails.root + 'upload'
    @name = file.original_filename
    @time = DateTime.now
    @ext = File.extname(@name)
    @hash_value = _hash(@name, @time) + @ext

    @path = File.join(@dir, @hash_value)
    File.open(@path, "wb") { |f| f.write(file.read) }
  end

  def _hash(name, time)
    Digest::MD5.hexdigest(Digest::SHA1.hexdigest( name + time.to_formatted_s(:db) ))
  end
end
