# Go Template
A template of the dockerized development environment for apps in Go.

## Kickstart
1. In `Makefile` change `APP_NAME` _(part of image and container name)_ && `APP_HOME` _(app home directory, subdirectory of `/go/src/`)_
2. `make build`
3. `make up`



### VIM ...or something
4. `make console`
5. Write some code
6. `go mod init` / `go mod tidy`
7. `make go`
8. `./bin/{APP_NAME}`


### Visual Studio Code
1. On left bottom corner click `><` icon and select `Attach to running container...` and select container `$(APP_NAME)`
2. Install (Ctrl + Shift + X): 
    - Remote - Containers (Microsoft)
    - Go (Go Team at Google)
3. Run command (Ctrl + Shift + P) `Go: Install/Update tools`, select all and click `OK`
