#!/usr/bin/env python3
"""Build Rust's LLVM from its release sources, avoiding expired CI artifacts."""
import argparse
from pathlib import Path


def prepare(source: Path) -> None:
    makefile = source / "feeds/packages/lang/rust/Makefile"
    content = makefile.read_text(encoding="utf-8")
    original = "--set=llvm.download-ci-llvm=true"
    replacement = (
        "--set=llvm.download-ci-llvm=false \\\n"
        "\t--set=llvm.link-jobs=1 \\\n"
        "\t--set=llvm.targets='AArch64;X86'"
    )
    if replacement in content:
        return
    if content.count(original) != 1:
        raise RuntimeError("Unexpected Rust recipe: review LLVM configuration before building")
    makefile.write_text(content.replace(original, replacement), encoding="utf-8", newline="\n")
    print("Rust: use release-source LLVM for AArch64/X86, with one linker job")


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("source", type=Path)
    prepare(parser.parse_args().source)
