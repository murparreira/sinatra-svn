class MyApp < Sinatra::Base

  get '/' do
    erb :index
  end

  get '/test-flash' do
    flash[:notice] = "Can't find that note."
    redirect '/'
  end

  get '/status' do
    cmd = "svn status #{settings.trunk_path}"
    string = `#{cmd}`
    string[0..7] = ''
    @files = string.split(/\n.\s+/)
    @files.last.chomp!
    erb :status
  end

  get '/diff_file' do
    @file = params[:file]
    cmd = "svn diff #{@file}"
    @diff = `#{cmd}`
    erb :diff_file
  end

  get '/diff' do
    cmd = "diff --exclude-from='/var/www/html/exclude.txt' --brief -r #{settings.trunk_path} #{settings.production_path}"
    string = `#{cmd}`
    @files = string.split(/\n/)
    @files.delete_if{|d| d.include?("Only in #{settings.production_path}")}
    @files.map! do |d|
      if d.include?('Only in')
        d[0..7] = ''
        d.sub!(':', '')
        a = d.split
        a.join('/')
      elsif d.include?('Files')
        a = d.split
        a.delete_if{|e| !e.include?('/trunk')}
        a.join
      end
    end
    erb :diff
  end

  get '/update_trunk' do
    cmd = "svn update #{settings.trunk_path}"
    msg = `#{cmd}`
    flash[:notice] = msg
    redirect '/'
  end

  get '/update_prod' do
    cmd = "svn update #{settings.production_path}"
    msg = `#{cmd}`
    flash[:notice] = msg
    redirect '/'
  end

end