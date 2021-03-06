FROM python:3.6-slim

WORKDIR /code

COPY requirements.txt \
        LICENSE \
        README.md \
        dorpsgek.ini \
        /code/
COPY dorpsgek_irc /code/dorpsgek_irc

RUN pip install -r requirements.txt

# Validate that what was installed was what was expected
RUN pip freeze 2>/dev/null | grep -v "dorpsgek-irc" > requirements.installed \
        && diff -u --strip-trailing-cr requirements.txt requirements.installed 1>&2 \
        || ( echo "!! ERROR !! requirements.txt defined different packages or versions for installation" \
                && exit 1 ) 1>&2

ENTRYPOINT ["python", "-m", "dorpsgek_irc"]
CMD []
