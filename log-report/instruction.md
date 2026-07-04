There is an access log in the working directory. Analyze the traffic and summarize
what you find — how many requests there were, the clients involved, and which pages
were popular. Save your findings to /app/report.json as a JSON object with exactly these
keys and values:

{
  "total_requests": 6,
  "unique_ips": 3,
  "top_path": "/index.html"
}
