# Custom Nginx Builder

## Usage

To copy out the built packages:

```
docker run -it yanatan16/custom-nginx-builder bash
```

Then upload to whereever you keep your packages.

## Changing

To add more packages or update some, just fork this repo and update the `Dockerfile`, `rules`, and `changelog`. Then rebuild with:

```
docker build -t <username>/custom-nginx-builder .
```

## License

See `LICENSE` file.