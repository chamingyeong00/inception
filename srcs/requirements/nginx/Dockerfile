FROM alpine:3.19

RUN apk update && apk add --no-cache nginx openssl

# SSL 인증서 생성 보관 폴더
RUN mkdir -p /etc/nginx/ssl

# 인증서 자가 서명 (Self-signed) 발급
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/inception.key \
    -out /etc/nginx/ssl/inception.crt \
    -subj "/C=KR/ST=Seoul/L=Seoul/O=42Gyeongsan/OU=Cadet/CN=micha.42.fr"

# 설정 파일 복사
COPY conf/nginx.conf /etc/nginx/nginx.conf

# 포그라운드 실행 (tail -f 같은 꼼수 금지 규칙 준수)
CMD ["nginx", "-g", "daemon off;"]