# ---- builder stage ----
FROM node:20-alpine AS builder
WORKDIR /app
COPY app/server.js ./server.js

# ---- runtime stage (small + non-root) ----
FROM gcr.io/distroless/nodejs20-debian12:nonroot
WORKDIR /app
COPY --from=builder /app/server.js ./server.js

ENV PORT=80
EXPOSE 80
CMD ["server.js"]
