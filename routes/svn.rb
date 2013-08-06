class MyApp < Sinatra::Base

  get '/' do
    erb :index
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
    cmd = "diff --exclude-from='public/exclude.txt' --brief -r #{settings.trunk_path} #{settings.production_path}"
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

  post '/commit_trunk' do
    selected = params[:files]
    mensagem = params[:mensagem]
    selected.each do |s|
      cmd_add = "svn add #{s}"
      msg_add = `#{cmd_add}`
    end
    cmd_commit = "svn commit #{selected.join(' ')} -m '#{mensagem}'"
    msg_commit = `#{cmd_commit}`
    flash[:notice] = msg_commit
    redirect '/status'
  end

  post '/commit_producao' do
    trunk_folder = settings.trunk_path.split('/').last
    production_folder = settings.production_path.split('/').last
    selected = params[:files]
    mensagem = params[:mensagem]
    selected.each do |s|
      file_production_path = s.gsub("/#{trunk_folder}/", "/#{production_folder}/")
      cmd_copy = "cp -R #{s} #{file_production_path}"
      `#{cmd_copy}`
      cmd_add = "svn add #{file_production_path}"
      `#{cmd_add}`
    end
    selected_production = selected.map {|s| s.gsub("/#{trunk_folder}/", "/#{production_folder}/")}
    cmd_commit = "svn commit #{selected_production.join(' ')} -m '#{mensagem}'"
    msg_commit = `#{cmd_commit}`
    flash[:notice] = msg_commit
    redirect '/diff'
  end

  get '/history_trunk' do
    cmd = "svn log #{settings.trunk_path} --limit 10 -v"
    @history = `#{cmd}`    
    erb :history
  end

  get '/history_production' do
    cmd = "svn log #{settings.production_path} --limit 10 -v"
    @history = `#{cmd}`    
    erb :history
  end

end