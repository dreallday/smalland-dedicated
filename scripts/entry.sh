#!/bin/bash

cd ${STEAMAPPDIR}

#####################################
#                                   #
# Force an update if the env is set #
#                                   #
#####################################

if [ "${FORCEUPDATE}" == "1" ]; then
  echo "FORCEUPDATE variable is set, so the server will be updated right now"
  bash "${STEAMCMDDIR}/steamcmd.sh" +force_install_dir "${STEAMAPPDIR}" +login anonymous +app_update "${STEAMAPPID}" validate +quit
fi

PARAMS="/Game/Maps/WorldGame/WorldGame_Smalland?SERVERNAME=\"${SERVERNAME}\"?WORLDNAME=\"${WORLDNAME}\""
[ "${PASSWORD}" != "" ] && PARAMS="${PARAMS}?PASSWORD=\"${PASSWORD}\""
[ "${FRIENDLYFIRE}" = 1 ] && PARAMS="${PARAMS}?FRIENDLYFIRE"
[ "${PEACEFULMODE}" = 1 ] && PARAMS="${PARAMS}?PEACEFULMODE"
[ "${KEEPINVENTORY}" = 1 ] && PARAMS="${PARAMS}?KEEPINVENTORY"
[ "${NODETERIORATION}" = 1 ] && PARAMS="${PARAMS}?NODETERIORATION"
[ "${PRIVATE}" = 1 ] && PARAMS="${PARAMS}?PRIVATE"
PARAMS="${PARAMS}?lengthofdayseconds=${LENGTHOFDAYSECONDS}"
PARAMS="${PARAMS}?lengthofseasonseconds=${LENGTHOFSEASONSECONDS}"
PARAMS="${PARAMS}?creaturehealthmodifier=${CREATUREHEALTHMODIFIER}"
PARAMS="${PARAMS}?creaturedamagemodifier=${CREATUREDAMAGEMODIFIER}"
PARAMS="${PARAMS}?nourishmentlossmodifier=${NOURISHMENTLOSSMODIFIER}"
PARAMS="${PARAMS}?falldamagemodifier=${FALLDAMAGEMODIFIER}"
PARAMS="${PARAMS} -ini:Engine:[EpicOnlineServices]:DeploymentId=${DEPLOYMENTID}"
PARAMS="${PARAMS} -ini:Engine:[EpicOnlineServices]:DedicatedServerClientId=${CLIENTID}"
PARAMS="${PARAMS} -ini:Engine:[EpicOnlineServices]:DedicatedServerClientSecret=${CLIENTSECRET}"
[ "${PRIVATEKEY}" != "" ] && PARAMS="${PARAMS} -ini:Engine:[EpicOnlineServices]:DedicatedServerPrivateKey=${PRIVATEKEY}"
PARAMS="${PARAMS} -port=${PORT}"
PARAMS="${PARAMS} -NOSTEAM -log"

echo "Starting SMALLAND server as:"
echo "./SMALLANDServer.sh $PARAMS"

su - steam -c "cd ${STEAMAPPDIR} && pwd && ./SMALLANDServer.sh ${PARAMS}"