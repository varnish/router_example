vcl 4.1;

backend default {
    .host = "origin.example.com";
    .port = "80";
}

sub vcl_recv {
    if (req.url ~ "/ping") {
        return (synth(200, "OK"));
    }
    set req.url = regsub(req.url, "/([^/]*)/", "/");
}

sub vcl_backend_response {
    set beresp.http.Access-Control-Allow-Origin = "*";
    set beresp.http.Access-Control-Allow-Methods = "GET,HEAD";
}

