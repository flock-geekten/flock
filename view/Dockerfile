FROM node:12.18.4

WORKDIR /app/nuxt-project/flock-view

RUN npm install -g @vue/cli

CMD ["/bin/sh"]

COPY ./flock_view /app/nuxt-project/flock-view
RUN npm install
RUN npm install -g create-nuxt-app

