FROM emqx/emqx:4.4.3

COPY docker-entrypoint.sh /usr/bin/

ENTRYPOINT ["/usr/bin/docker-entrypoint.sh"]

CMD ["/opt/emqx/bin/emqx","foreground"]
  
