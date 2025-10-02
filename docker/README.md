# docker

The Dockerfile in this directory can be used to build the libadalang tools in a container.

To create the container, first install [Docker Desktop](https://www.docker.com/products/docker-desktop/), then run:

   ```
   $ ./env.sh start
   ```

Once the container is built, you can log into the container by running.

   ```
   $ ./env.sh login
   ```

The libadalang tools will already be included in the build path.

The container can be started or stopped via:

  ```
  $ ./env.sh start
  $ ./env.sh stop
  ```

and the image can be recreated from scratch by running:
  
  ```
  $ ./env.sh build
  ```

Enjoy.
