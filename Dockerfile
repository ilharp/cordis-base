# syntax=docker/dockerfile:1

FROM node:22.14.0-alpine3.21

RUN ["apk", "add", "--no-cache", "chromium", "nss", "freetype", "harfbuzz", "ca-certificates", "ttf-freefont", "font-noto-cjk"]
