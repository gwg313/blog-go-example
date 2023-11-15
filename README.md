# Nix Go Example

A very basic example of developing in Nix i cover in my blog [here](https://blog.gwg313.xyz/) 

## Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
  - [Usage](#usage)

## Overview

This is a very basic go project to demonstrate Nix flakes and devShell for development.

## Features

- Nix Flake based development environment
- Nix Flake based Build.
- Nix Flake based CI.

## Getting Started

To use this project install the Nix Package manager, instructions [here](https://nixos.org/manual/nix/stable/installation/installation.html)

### Prerequisites

Just Nix

### Installation

```bash
git clone https://github.com/gwg313/blog-go-example.git
```

### Usage

#### Entering the development environment
```bash
nix develop
```
#### Building the project
```bash
nix build
```
#### Running CI checks locally
Enter the development environment and 
```bash
my-ci-checks
```
