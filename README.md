# Sendly Ruby Sinatra OTP Verification Example

A complete phone number verification example using Sendly's OTP service with Ruby and Sinatra.

## Features

- Send OTP codes to phone numbers
- Verify OTP codes
- Modern, responsive UI
- Error handling and user feedback
- RESTful JSON API endpoints

## Prerequisites

- Ruby 3.0 or higher
- Bundler
- Sendly API key

## Installation

1. Clone or download this example

2. Install dependencies:
```bash
bundle install
```

3. Create a `.env` file from the example:
```bash
cp .env.example .env
```

4. Add your Sendly API key to `.env`:
```
SENDLY_API_KEY=your_actual_api_key_here
```

## Running the Application

Start the server:
```bash
bundle exec rackup -p 4567
```

The application will be available at `http://localhost:4567`

## Usage

1. Open `http://localhost:4567` in your browser
2. Enter a phone number in E.164 format (e.g., +1234567890)
3. Click "Send OTP"
4. Enter the 6-digit code you received
5. Click "Verify OTP"

## API Endpoints

### POST /send-otp
Send an OTP code to a phone number.

**Request:**
```json
{
  "phone": "+1234567890"
}
```

**Response:**
```json
{
  "success": true,
  "id": "ver_xxx",
  "message": "OTP sent successfully"
}
```

### POST /verify-otp
Verify an OTP code.

**Request:**
```json
{
  "id": "ver_xxx",
  "code": "123456"
}
```

**Response:**
```json
{
  "success": true,
  "message": "Phone number verified successfully!"
}
```

## Project Structure

```
.
├── app.rb              # Main Sinatra application
├── config.ru           # Rack configuration
├── Gemfile             # Ruby dependencies
├── views/
│   ├── layout.erb      # HTML layout template
│   ├── index.erb       # Phone number input page
│   └── verify.erb      # OTP verification page
├── .env.example        # Environment variables template
├── .gitignore          # Git ignore rules
└── README.md           # This file
```

## Dependencies

- **sinatra** - Web framework
- **sinatra-contrib** - Sinatra extensions (JSON helpers)
- **sendly** - Sendly Ruby SDK
- **dotenv** - Environment variable management
- **puma** - Web server
- **rackup** - Rack server runner

## Learn More

- [Sendly Documentation](https://sendly.so/docs)
- [Sendly Ruby SDK](https://github.com/sendly/sendly-ruby)
- [Sinatra Documentation](http://sinatrarb.com/)

## License

MIT
