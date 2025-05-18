# syntax=docker/dockerfile:1

FROM node:24.0.2-alpine3.21

RUN ["apk", "add", "--no-cache", "chromium", "nss", "freetype", "harfbuzz", "ca-certificates", "ttf-freefont", "font-noto-cjk"]
