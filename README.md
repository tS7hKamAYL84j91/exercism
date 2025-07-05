# Exercism Solutions

My solutions to programming exercises from [Exercism](https://exercism.io), organized by programming language.

## Overview

This repository contains my solutions to various programming exercises across multiple languages. Each exercise is organized by language and includes the solution files along with any test files and documentation.

## Languages & Exercises

### 🟣 Elixir (100+ exercises)

The largest collection with exercises covering:

- **Fundamentals**: hello-world, two-fer, leap, raindrops
- **Data Structures**: binary-search-tree, custom-set, simple-linked-list
- **Algorithms**: binary-search, sieve, prime-factors
- **String Processing**: anagram, pangram, isogram, acronym
- **Mathematical**: grains, perfect-numbers, armstrong-numbers
- **Games & Logic**: minesweeper, poker, bowling, connect
- **Cryptography**: atbash-cipher, rotational-cipher, crypto-square
- **Advanced**: diffie-hellman, protein-translation, rna-transcription

### 🔵 F# (20 exercises)

Functional programming solutions including:

- **Basics**: hello-world, two-fer, leap, raindrops
- **Data Processing**: accumulate, grade-school
- **Games**: guessing-game, annalyns-infiltration, cars-assemble
- **Time & Space**: clock, space-age, booking-up-for-beauty
- **Logic**: queen-attack, robot-simulator, kindergarten-garden

### 🔴 Julia (40+ exercises)

Scientific computing and numerical exercises:

- **Core**: hello-world, leap, raindrops, bob
- **Mathematics**: grains, perfect-numbers, armstrong-numbers
- **Data Structures**: custom-set, binary-search
- **String Processing**: anagram, pangram, acronym
- **Algorithms**: sieve, prime-factors, hamming
- **Advanced**: minesweeper, complex-numbers, rational-numbers

### 🟠 Rust (5 exercises)

Systems programming solutions:

- **Fundamentals**: hello-world, leap, raindrops
- **Time**: gigasecond
- **Strings**: reverse-string

### 🟡 ReasonML (20 exercises)

OCaml-based functional programming:

- **Basics**: hello-world, two-fer, leap, raindrops
- **Data Processing**: accumulate, anagram, acronym
- **Algorithms**: binary-search, armstrong-numbers
- **String Processing**: pangram, isogram, word-count
- **Advanced**: protein-translation, rna-transcription

### 🟢 OCaml (20 exercises)

Functional programming with OCaml:

- **Fundamentals**: hello-world, leap, raindrops
- **Data Structures**: binary-search, custom-set
- **Algorithms**: sieve, prime-factors, hamming
- **String Processing**: anagram, pangram, word-count
- **Games**: beer-song, bracket-push

### 🔶 ClojureScript (4 exercises)

Lisp-based functional programming:

- **Basics**: hello-world, leap, raindrops, triangle

### 🟦 PureScript (2 exercises)

Haskell-inspired functional programming:

- Limited collection with basic exercises

### 🟥 Racket (5 exercises)

Scheme-based functional programming:

- Small collection of fundamental exercises

### 🟪 Swift (1 exercise)

Apple's programming language:

- Single exercise in the collection

## Repository Structure

```
exercism/
├── elixir/          # 100+ exercises
├── fsharp/          # 20 exercises  
├── julia/           # 40+ exercises
├── rust/            # 5 exercises
├── reasonml/        # 20 exercises
├── ocaml/           # 20 exercises
├── clojurescript/   # 4 exercises
├── purescript/      # 2 exercises
├── racket/          # 5 exercises
└── swift/           # 1 exercise
```

Each language directory contains subdirectories for individual exercises, typically including:

- Solution files (`.exs`, `.fs`, `.jl`, `.rs`, etc.)
- Test files
- README with exercise description
- Project configuration files

## Getting Started

### Prerequisites

- Install the [Exercism CLI](https://exercism.io/docs/using/solving-exercises/working-locally)
- Install the required language toolchains for the exercises you want to run

### Running Exercises

1. **Navigate to a specific exercise:**

   ```bash
   cd elixir/hello-world
   ```

2. **Run tests:**

   ```bash
   # Elixir
   mix test
   
   # F#
   dotnet test
   
   # Julia
   julia runtests.jl
   
   # Rust
   cargo test
   ```

3. **Submit to Exercism:**

   ```bash
   exercism submit path/to/solution
   ```

## Learning Progress

This repository represents my journey through different programming paradigms:

- **Functional Programming**: Elixir, F#, ReasonML, OCaml
- **Systems Programming**: Rust
- **Scientific Computing**: Julia
- **Lisp Family**: ClojureScript, Racket
- **Type-Safe**: PureScript

## Contributing

This is a personal learning repository, but suggestions for improvements or alternative solutions are welcome through issues or discussions.

## License

This project is for educational purposes. Exercise descriptions and test cases are from [Exercism](https://exercism.io) and are subject to their licensing terms.

---

*Built with ❤️ and lots of coffee while learning different programming languages*
