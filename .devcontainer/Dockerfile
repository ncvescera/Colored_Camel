FROM ocaml/opam:latest

RUN sudo apt-get update && sudo apt upgrade -y
RUN sudo apt-get install -y zlib1g-dev libffi-dev libcairo2-dev libgmp-dev libzmq5-dev pkg-config
RUN sudo apt install -y make python3 python3-pip
RUN pip3 install jupyter
ENV PATH $PATH:/home/opam/.local/bin
RUN opam update
RUN opam user-setup install
RUN opam install -y ocaml-lsp-server
RUN opam install -y merlin
RUN opam install jupyter
RUN opam upgrade jupyter
RUN grep topfind ~/.ocamlinit || echo '#use "topfind";;' >> ~/.ocamlinit  # For using '#require' directive
RUN grep Topfind.log ~/.ocamlinit || echo 'Topfind.log:=ignore;;' >> ~/.ocamlinit  # Suppress logging of topfind (recommended but not necessary)
RUN opam exec -- ocaml-jupyter-opam-genspec
RUN jupyter kernelspec install --user --name ocaml-jupyter "$(opam config var share)/jupyter"
