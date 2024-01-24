# docker

The Dockerfile in this directory can be used to build the libadalang tools in a container.

To create the container, first install [Docker Desktop](https://www.docker.com/products/docker-desktop/), then run:

   ```
   $ ./create_container.sh
   ```

Once the container is built, you can log into the container by running.

   ```
   $ ./login_container.sh
   ```

The libadalang tools will already be included in the build path.

The container can be started or stopped via:

  ```
  $ ./start_container.sh
  $ ./stop_container.sh
  ```

and the image can be recreated from scratch by running:
  
  ```
  $ ./build_image.sh
  ```

Enjoy.
