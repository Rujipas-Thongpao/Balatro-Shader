#ifndef CUSTOM_NOISE
#define CUSTOM_NOISE

// Helper function: Fade curve to smooth interpolation
float fade(float t) {
    return t * t * t * (t * (t * 6.0 - 15.0) + 10.0);
}

// Helper function: Linear interpolation
float lerp(float a, float b, float t) {
    return a + t * (b - a);
}

// Helper function: Gradient calculation
float grad(int hash, float x, float y) {
    int h = hash & 7;  // Use lower 3 bits of hash
    float u = h < 4 ? x : y;
    float v = h < 4 ? y : x;
    return ((h & 1) == 0 ? u : -u) + ((h & 2) == 0 ? v : -v);
}

// Hash function for grid point gradients
int hash(int x, int y) {
    return (x * 57 + y * 131) & 255; // Simple hash function
}

// Perlin noise function
float perlinNoise(float2 p) {
    // Grid cell coordinates
    int x0 = (int)floor(p.x);
    int x1 = x0 + 1;
    int y0 = (int)floor(p.y);
    int y1 = y0 + 1;

    // Local coordinates inside cell
    float2 f = frac(p);

    // Fade curve values for interpolation
    float u = fade(f.x);
    float v = fade(f.y);

    // Gradient hashes for cell corners
    int h00 = hash(x0, y0);
    int h01 = hash(x0, y1);
    int h10 = hash(x1, y0);
    int h11 = hash(x1, y1);

    // Gradient contributions
    float g00 = grad(h00, f.x, f.y);
    float g10 = grad(h10, f.x - 1.0, f.y);
    float g01 = grad(h01, f.x, f.y - 1.0);
    float g11 = grad(h11, f.x - 1.0, f.y - 1.0);

    // Bilinear interpolation
    float nx0 = lerp(g00, g10, u);
    float nx1 = lerp(g01, g11, u);
    return lerp(nx0, nx1, v);
}

#endif
