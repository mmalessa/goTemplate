# Go Template
A template of the dockerized development environment for apps in Go.

## Kickstart
1. Change `APP_NAME` in `Makefile`
2. `make build`
3. `make up`



### VIM ...or something
4. `make console`
5. Write some code
6. `go mod init` / `go mod tidy`
7. `make go`
8. `./bin/{APP_NAME}`


### Visual Studio Code
4. Install (Ctrl + Shift + X): 
    - Remote - Containers (Microsoft)
    - Go (Go Team at Google)
5. Run command (Ctrl + Shift + P) `Go: Install/Update tools`, select all and click `OK`
6. On left bottom corner click `><` icon and select `Attach to running container...` and select container `$(APP_NAME)`