build:
	zig build -Drelease-small=true
	w4 bundle zig-out/lib/cart.wasm --html ./index.html

run: build
	w4 run zig-out/lib/cart.wasm
