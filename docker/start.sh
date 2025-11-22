#!/usr/bin/env bash

cd $(dirname "${BASH_SOURCE[0]}")/..
source docker/utils.sh

DEV_IMAGE="xiangquan/grounding-dino:0.1"
DEV_CONTAINER="grounding-dino-${USER}"

sudo chmod 777 /var/run/docker.sock

if [ "$1" == "new" ]; then
    docker rm -f "${DEV_CONTAINER}" 2> /dev/null
fi
if ! reuse "${DEV_CONTAINER}"; then
    WORKDIR=$(pwd)
    docker run -d -it --privileged --gpus all \
        --name "${DEV_CONTAINER}" \
        --hostname "${DEV_CONTAINER}" \
        --network=host \
        --add-host "${DEV_CONTAINER}:127.0.0.1" \
        -e USER=${USER} \
        -e GROUP=$(id -g -n) \
        -e HOST_UID=$(id -u) \
        -e HOST_GID=$(id -g) \
        -e HOST_WORKDIR="${WORKDIR}" \
        -e DISPLAY="${DISPLAY}" \
        -e XDG_RUNTIME_DIR="${XDG_RUNTIME_DIR}" \
        -v "${XDG_RUNTIME_DIR}:${XDG_RUNTIME_DIR}" \
        -v "${WORKDIR}:/work/GroundingDINO" \
        -v "${WORKDIR}:${WORKDIR}" \
	-e "PYTHONPATH=${WORKDIR}" \
        -w "/work/GroundingDINO" \
        ${DEV_IMAGE} \
        bash -c -- '
            if [ "${USER}" != "root" ]; then
                addgroup --gid ${HOST_GID} ${USER}
                adduser --disabled-password --force-badname --gecos "" ${USER} --uid ${HOST_UID} --gid ${HOST_GID}
                chown ${USER}:${GROUP} /work
                usermod -aG sudo ${USER}
            fi

            touch /tmp/READY
            bash
        '
    while ! docker exec ${DEV_CONTAINER} ls /tmp/READY >/dev/null 2>&1; do
        sleep 0.1
    done
fi

docker exec -it -u ${USER} ${DEV_CONTAINER} bash
