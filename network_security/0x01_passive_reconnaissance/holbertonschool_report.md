# Holberton School Shodan Reconnaissance Report

## Domain Information
**Domain:** holbertonschool.com

## IP Ranges
Based on Shodan analysis, the following IP addresses and ranges are associated with the domain:

* **99.83.190.102** (AWS Global Accelerator)
* **75.2.70.75** (AWS Global Accelerator)
* **63.35.51.142** (Amazon AWS)
* **54.157.56.129** (Amazon AWS - Virginia)
* **52.85.96.82** (Amazon CloudFront)
* **13.37.98.87** (Amazon AWS - Paris)
* **104.16.53.111** (Cloudflare)

## Technologies and Frameworks
Analysis of subdomains reveals the use of the following technologies:

* **Web Servers:**
    * Nginx
    * Cloudflare Server
    * Amazon S3 (Simple Storage Service)

* **Frameworks & CMS:**
    * **Ruby on Rails:** Used on `apply.holbertonschool.com` and assets subdomains.
    * **Webflow:** Used on the main website and `fr.webflow.holbertonschool.com`.
    * **Discourse:** Used on `lvl2-discourse-staging.holbertonschool.com`.

* **Cloud Providers:**
    * **Amazon Web Services (AWS):** Hosting most infrastructure (EC2, S3, CloudFront).
    * **Cloudflare:** Used for DNS, CDN, and DDoS protection on support subdomains.

* **Other Technologies:**
    * **SSL/TLS:** Let's Encrypt certificates are widely used.
    * **Operating Systems:** Ubuntu (detected on some EC2 instances).
