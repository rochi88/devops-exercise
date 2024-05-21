# This Dockerfile builds an image for the data-svc service, which is built with
# the Rust programming language using the Rocket framework.
#
# The image is composed of two layers. The first layer is built using the
# rust:1.70.0-slim-bullseye image, which provides a minimal Rust development
# environment. The second layer is a minimal Debian image.
#
# The first layer copies the Cargo.toml and Cargo.lock files from the
# build context, and compiles the data-svc application in release mode. The
# compiled binary is then copied to the /bin directory.
#
# The second layer copies the compiled binary from the build layer, and
# sets an environment variable for the Rocket framework to listen on all
# available network interfaces.
#
# The final command is to run the compiled binary, which starts the Rocket
# web server.
#
FROM rust:1.70.0-slim-bullseye AS build

# View app name in Cargo.toml
ARG APP_NAME=data-svc

WORKDIR /build

# Copy Cargo.toml and Cargo.lock files from build context
COPY Cargo.lock Cargo.toml ./
# Copy source code from build context
COPY src src
# Compile application in release mode
RUN cargo build --locked --release
# Copy compiled binary to /bin directory
RUN cp ./target/release/$APP_NAME /bin/server

FROM debian:bullseye-slim AS final
# Copy compiled binary from build layer to final layer
COPY --from=build /bin/server /bin/
# Set environment variable for Rocket framework
ENV ROCKET_ADDRESS=0.0.0.0
# Run compiled binary
CMD ["/bin/server"]
