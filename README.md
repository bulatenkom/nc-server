# nc-server

## Description

Simple netcat server wrapped into bash script (So you can treat it as a pseudo bash server).

The main 'nc-server.sh' script runs netcat listen infintely for handling incoming http requests. On each request, an html page is generated based on template.

**Note!** Don't use it in production. This is a POC (Proof of concept), no more, no less.

## Usage

### Run server

Run netcat server as a background job.

```bash
bash nc-server.sh & # default port: 8888
```
or
```bash
chmod u+x nc-server.sh
./nc-server.sh & # default port: 8888
```

### Configuration

nc-server accepts three variables:
- `port` - (optional) port to listen (default: 8888)
- `heading` - (optional) text heading rendered in index.template.html
- `content` - (optional) text content rendered in index.template.html

Example of configured server:

```bash
port=8080 \
heading='Welcome to Petland page!' \
content='Cats are cute.' \
    bash nc-server.sh &
```

### Requests (Default configuration)

**Option 1.** Open web browser (e.g. Chrome) → Go to address (http://localhost:8888)

**Option 2.** Request server with `curl` utility
```bash
curl localhost:8888
```

In both cases you should get a response with status 200 and html body like:
```
Default heading
Default content
```

### Stop server

```bash
kill -TERM -PID # where PID is a process id of running netcat server (hint. use `ps -f` to list running processes in current shell)
```

Example of `ps -f`.

```
UID   PID  PPID   C STIME   TTY           TIME CMD
  501   666   665   0 11:51PM ttys000    0:00.21 -zsh
  501  1917   666   0  1:42AM ttys000    0:00.01 bash nc-server.sh <-- Kill this process
  501  1939  1917   0  1:42AM ttys000    0:00.00 nc -l 8888
  501  1163  1162   0 12:40AM ttys001    0:00.13 -zsh
```

### Optimizations

Current implementation renders html page on each request, which can be used for dynamic content generation.

In case a static page is enough, render part can be rewritten with usage of prepopulated variables (prerendered html page).

Another downside is calculation of content-length header which uses `wc` utilility, which spawns separate process. Can be replaced with a function if you are a smart one and not a lazy one.

---

### Created by

Mark Bulatenko (@bulatenkom)