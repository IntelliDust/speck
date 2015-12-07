print("HEAP "..node.heap().." bytes")
print("Service: HTTPD starting")
  dofile("core-httpserver.lc")(cfg.http.port)
print("Service: HTTPD started")

