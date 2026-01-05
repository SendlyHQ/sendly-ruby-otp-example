require 'sinatra'
require 'sinatra/json'
require 'sendly'
require 'dotenv/load'

configure do
  set :show_exceptions, :after_handler
end

helpers do
  def sendly_client
    @sendly_client ||= Sendly::Client.new(ENV['SENDLY_API_KEY'])
  end
end

get '/' do
  erb :index
end

post '/send-otp' do
  content_type :json
  
  begin
    data = JSON.parse(request.body.read)
    phone = data['phone']
    
    if phone.nil? || phone.strip.empty?
      halt 400, { error: 'Phone number is required' }.to_json
    end
    
    verification = sendly_client.verify.send(phone: phone)
    
    { 
      success: true, 
      id: verification.id,
      message: 'OTP sent successfully' 
    }.to_json
  rescue JSON::ParserError
    halt 400, { error: 'Invalid JSON' }.to_json
  rescue => e
    halt 500, { error: e.message }.to_json
  end
end

get '/verify' do
  @verification_id = params[:id]
  
  if @verification_id.nil? || @verification_id.strip.empty?
    redirect '/'
  else
    erb :verify
  end
end

post '/verify-otp' do
  content_type :json
  
  begin
    data = JSON.parse(request.body.read)
    id = data['id']
    code = data['code']
    
    if id.nil? || id.strip.empty?
      halt 400, { error: 'Verification ID is required' }.to_json
    end
    
    if code.nil? || code.strip.empty?
      halt 400, { error: 'OTP code is required' }.to_json
    end
    
    result = sendly_client.verify.check(id, code: code)
    
    if result.status == 'verified'
      { 
        success: true, 
        message: 'Phone number verified successfully!' 
      }.to_json
    else
      halt 400, { 
        error: 'Invalid or expired OTP code' 
      }.to_json
    end
  rescue JSON::ParserError
    halt 400, { error: 'Invalid JSON' }.to_json
  rescue => e
    halt 500, { error: e.message }.to_json
  end
end
