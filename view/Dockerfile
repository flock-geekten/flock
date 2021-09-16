FROM node:12.18.4

WORKDIR /app/nuxt-project/flock-view

RUN npm install -g @vue/cli

CMD ["/bin/sh"]

COPY ./flock_view /app/nuxt-project/flock-view
RUN npm install
RUN npm install -g create-nuxt-app
RUN npm install firebase
RUN npm install firebase@9.0.0
RUN npm install -g firebase-tools
RUN npm install vuex-persistedstate
RUN npm install @nuxtjs/markdownit
RUN npm install @nuxtjs/device
RUN yarn add firebase
RUN yarn add @nuxtjs/dotenv
RUN yarn add @nuxtjs/markdownit
