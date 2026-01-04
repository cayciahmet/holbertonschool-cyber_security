# Holberton School Reconnaissance Report

## 1. Introduction
This report details the passive reconnaissance findings for the domain `holbertonschool.com`. The information was gathered using Shodan and other passive analysis techniques to identify IP ranges, hosting providers, and technologies used across subdomains.

## 2. IP Ranges and Hosting
The infrastructure for `holbertonschool.com` is distributed across several cloud providers and CDNs.

* **Amazon Web Services (AWS):**
    * IP: `54.157.56.129` (Virginia, US)
    * IP: `13.37.98.87` (Paris, FR)
    * IP: `63.35.51.142` (Ireland)
    * IP Range: `52.85.96.0/24` (Amazon CloudFront CDN)
    * AWS Global Accelerator IPs: `99.83.190.102`, `75.2.70.75`

* **Cloudflare:**
    * IP: `104.16.53.111` (Used for support and protection)

* **Other Providers:**
    * Highwinds Network Group (CDN services)

## 3. Technologies and Frameworks
Various technologies were identified across different subdomains:

### Web Servers & CDNs
* **Nginx:** A widely used web server detected on several subdomains.
* **Cloudflare Server:** Used for caching and security.
* **Amazon S3:** Used for serving static assets (images, documents).

### Frameworks & CMS
* **Ruby on Rails:** Detected on `apply.holbertonschool.com` and asset management subdomains. This suggests the application portal is built with Rails.
* **Webflow:** The main website (`www.holbertonschool.com`) and `fr.webflow.holbertonschool.com` utilize Webflow as a CMS/Design tool.
* **Discourse:** The subdomain `lvl2-discourse-staging.holbertonschool.com` runs the Discourse forum software.

### Subdomains Identified
* `www.holbertonschool.com` (Main site)
* `apply.holbertonschool.com` (Application portal)
* `intranet.hbtn.io` (Student portal redirect)
* `support.holbertonschool.com` (Helpdesk)
* `assets.holbertonschool.com` (Static content)

## 4. Conclusion
The domain `holbertonschool.com` relies heavily on cloud infrastructure, primarily AWS and Cloudflare, to ensure scalability and security. The use of Ruby on Rails for dynamic applications and Webflow for the public-facing site indicates a modern tech stack.
