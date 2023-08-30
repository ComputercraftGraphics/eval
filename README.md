
# eval

This repository is for evaluating CC graphics libraries.

Evaluation comes in two parts:
* Benchmarks - measure the performance of various features
* Tests - verify the output of various features

This repository provides libraries which you can `require` in your own evaluation tools tailored to your own graphics libraries.

All tests and benchmarks come in pairs.

All benchmarks have the following properties:

Benchmark property | Type | Description
-|-|-
`iterations` | `integer` | Number of iterations.
`total_time` | `number` | Total time in seconds taken for all iterations combined. Can be assumed not to include overhead from the benchmarking library.
`time` | `number` | Average time in seconds taken per iteration. Equal to `total_time / iterations`.

See:
* [Benchmarking](Benchmarking.md)
* [Testing](Testing.md)

## 3D Raster Single

Property | Value
-|-
Dimensions | 3D
Polygon count | 1
Geometry | Varied configuration
Vertex transformation | None
Camera | Fixed origin
Viewport | Fixed fullscreen
Resolution | Varied standard sizes
Pixel shading | Fixed colour

Tests
* Pixels whose centres are within 0.001 units of an edge of the triangle may or may not be filled.
* All pixels whose centres are strictly within the edges of the triangle must be filled.
* No pixels whose centres are strictly outside the edges of the triangle must be filled.

Benchmark property | Type | Description
-|-|-
`configuration_name` | `string` | Human-friendly name of the configuration.
`flat` | `'none' \| 'top \| 'bottom' \| 'left' \| 'right'` | Which side of this triangle was flat, if any.
`horizontal_flat` | `boolean` | Whether any horizontal edge was flat, i.e. if `flat == 'top' or flat == 'bottom'`.
`pixels` | `integer` | Minimum number of pixels drawn (number of pixels whose centres are strictly within the triangle).

## 3D Raster Scene

Property | Value
-|-
Dimensions | 3D
Polygon count | Varied
Geometry | Varied scenes
Vertex transformation | None
Camera | Fixed origin
Viewport | Fixed fullscreen
Resolution | Varied
Pixel shading | Fixed colour

Benchmark property | Type | Description
-|-|-
`configuration_name` | `string` | Human-friendly name of the configuration.
`total_triangles` | `integer` | Total number of triangles contained within the scene.
`front_facing_triangles` | `integer` | Number of triangles contained within the scene which are facing towards the camera.
`visible_triangles` | `integer` | Number of triangles which are at least partially visible (i.e. not fully behind other triangles).

## 2D Image Blit Subpixel

Property | Value
-|-
Dimensions | 2D
Image contents | Varied palette colours
Resolution | Varied
Platforms | All

> TODO: I AM BORED PLEASE ADD THE BENCHMARK PROPERTIES HERE

## 2D Image Blit Graphics

Property | Value
-|-
Dimensions | 2D
Image contents | Varied palette colours
Resolution | Varied
Platforms | CraftOS-PC

> TODO: I AM BORED PLEASE ADD THE BENCHMARK PROPERTIES HERE
