Dotenv.load

require './helpers/helpers.rb'

class GbSite < Sinatra::Base
  set :gb, Gibbon.new(ENV['MAILCHIMP_KEY'])
  set :list_id, settings.gb.lists(filters: { list_name: 'gbfriends' })['data'].first['id']

  set :root, File.dirname(__FILE__)
  register Sinatra::AssetPack

  assets do
    serve '/css', from: 'assets/stylesheets'
    serve '/js',  from: 'assets/javascripts'

    css :index,     %w(/css/reset.css /css/index/*.css /css/font-awesome.css)
    css :portfolio, %w(/css/reset.css /css/portfolio/*.css)

    js :index,     %w(/js/jquery.js /js/jquery-ui.min.js /js/jquery.touchdown.min.js /js/application.js /js/index.js /js/preloadCssImages.jQuery_v5.js)
    js :portfolio, %w(/js/jquery.js /js/jquery-ui.min.js /js/jquery.touchdown.min.js /js/application.js /js/portfolio.js /js/preloadCssImages.jQuery_v5.js)

    css_compression :simple
  end

  get '/' do
    @assets = :index
    erb :index
  end

  post '/contact' do
    Pony.mail to: 'contact@groupbuddies.com',
              from: params[:email],
              reply_to: params[:email],
              subject: '[groupbuddies.com] Message from ' + params[:name],
              body: params[:message],
              via: :smtp,
              via_options: {
                address:              'smtp.gmail.com',
                port:                 '587',
                enable_starttls_auto: true,
                user_name:            ENV['NOREPLY_USERNAME'],
                password:             ENV['NOREPLY_PASSWORD'],
                authentication:       :plain # :plain, :login, :cram_md5, no auth by default
              }

    redirect to('/') unless request.xhr?
  end

  get '/portfolio/:name' do
    @assets = :portfolio

    @name = params[:name]

    erb :portfolio
  end

  post '/newsletter' do
    email_regex = /^[a-zA-Z0-9_.+\-]+@[a-zA-Z0-9\-]+\.[a-zA-Z0-9\-.]+$/

    if params[:email] =~ email_regex && !email_exists?('newsletter.txt', params[:email])
      add_to_newsletter('newsletter.txt', params[:email])

      settings.gb.listSubscribe id: settings.list_id,
                                email_address: params[:email],
                                merge_vars: { fname: 'GB', lname: 'User' },
                                double_optin: false,
                                send_welcome: true
      200
    else
      500
    end
  end

  error 404 do
    redirect to '/'
  end
end
