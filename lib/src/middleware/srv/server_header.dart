import 'dart:io';

HttpServer serverHeader(HttpServer srv)
{
    srv.serverHeader = 'dkit-spirit';
    return srv;
}