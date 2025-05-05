# Smart Laser - Netlify Deployment Guide

This document explains how to deploy the Smart Laser Flutter web application on Netlify.

## Deployment Steps

1. Log in to your Netlify account
2. Click "Import from Git" 
3. Select GitHub and authorize Netlify to access your repositories
4. Select the `smartlaser` repository
5. Configure the build settings (these should be automatically detected from the netlify.toml file):
   - Build command: `flutter build web --release`
   - Publish directory: `build/web`
6. Click "Deploy site"

## Netlify Flutter Plugin

This project uses the Netlify Flutter Build Plugin to handle Flutter web deployments. The plugin automatically installs Flutter and builds the web application during deployment.

## CORS and API Access

The application is configured to access the Perfect Laser API at `https://csp.perfectlaser.co.za`. The necessary CORS headers are set in the `web/index.html` file.

## Custom Domain

After deployment, you can configure a custom domain through the Netlify dashboard. 