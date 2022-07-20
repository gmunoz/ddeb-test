FROM ubuntu:focal

COPY ddeb_test.sh /

RUN /ddeb_test.sh
