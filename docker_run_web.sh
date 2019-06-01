docker run --rm \
  -it \
  -p 3000:3000 \
  -p 3035:3035 \
  -v "$(pwd)":/home/ubuntu/repo \
  --net="inquiry_default" \
  --name inquiry_web_run_1 \
  ktakase00/rubypg-learn:uv-201905 \
  bash
