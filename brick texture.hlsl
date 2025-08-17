//brick texture
// way1

float2 tex = uv / brickSize;
tex.x += fmod(floor(tex.y), 2) * 0.5;
tex = frac(tex);
float2 isBlock = step(mortar, tex) * step(tex, 1 - mortar);
float mask = isBlock.x * isBlock.y;
float3 fragcolor = lerp(color2, color1, mask);
return fragcolor;

// way2

// The below expression will get compiled
// into the output of this node
float2 tex = uv / brickSize;

float2 brick = floor(tex);
float2 pos = frac(tex);

float2 oddRow = float2(step(1.0, fmod(brick.y, 2.0)), 0);
brick.x += oddRow.x;

float offset = step(1, fmod(brick.y, 2.0)) * 0.5;
float2 posOffset = float2(offset, 0.0);
float2 posWithOffset = frac(tex - posOffset);

float maskX = step(mortar.x, posWithOffset.x);
float maskY = step(mortar.y, posWithOffset.y);
float brickMask = maskX * maskY;

float3 brickColor = float3(0.6, 0.2, 0.2);
float3 mortarColor = float3(0.3, 0.3, 0.3);

float3 finalColor = lerp(color2, color1, brickMask);
return finalColor;