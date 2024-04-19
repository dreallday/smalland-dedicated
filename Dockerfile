################################################
# Dockerfile that builds a Smalland Gameserver #
################################################
FROM cm2network/steamcmd:root

LABEL maintainer=""

ENV STEAMAPPID 808040
ENV STEAMAPP smalland
ENV STEAMAPPDIR "${HOMEDIR}/${STEAMAPP}"

# Name of the server as it should appear on the server browser screen (for example "My Server")
ENV SERVERNAME="Default Server"\
    # World name which corresponds to the the save file name (for example "World")
    WORLDNAME="World"\
    # Password, leave it empty for open servers (for example "myPassword", can be empty "")
    PASSWORD=""\
    # Friendly fire between players, aka PVP (0 or 1)
    FRIENDLYFIRE=0\
    # Peaceful mode (0 or 1)
    PEACEFULMODE=0\
    # Keep inventory on death (0 or 1)
    KEEPINVENTORY=0\
    # Disable building wather deterioration (0 or 1)
    NODETERIORATION=0\
    # Private server is hidden on the server browser (0 or 1)
    PRIVATE=0\
    # Length of day in seconds (default is 1800 which is 30 minutess)
    LENGTHOFDAYSECONDS=1800\
    # Length of season in seconds (default is 10800 which is 3 hours)
    LENGTHOFSEASONSECONDS=10800\
    # Creature health modifier (20-300 default is 100)
    CREATUREHEALTHMODIFIER=100\
    # Creature damage modifier (20-300 default is 100)
    CREATUREDAMAGEMODIFIER=100\
    # Nourishment loss modifier (0-100 default is 100)
    NOURISHMENTLOSSMODIFIER=100\
    # Fall damage modifier (50-100 default is 100)
    FALLDAMAGEMODIFIER=100 \
    # Additional configuration
    PORT=7777 \
    DEPLOYMENTID="50f2b148496e4cbbbdeefbecc2ccd6a3"\
    CLIENTID="xyza78918KT08TkA6emolUay8yhvAAy2"\
    CLIENTSECRET="aN2GtVw7aHb6hx66HwohNM+qktFaO3vtrLSbGdTzZWk"\
    PRIVATEKEY=""

# Install required packages
RUN apt-get update \
    && apt-get install -y --no-install-recommends --no-install-suggests \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Set the entry point file permissions
RUN set -x \
    && mkdir -p "${STEAMAPPDIR}" \
    && chown -R "${USER}:${USER}" "${STEAMAPPDIR}" \
    && bash "${STEAMCMDDIR}/steamcmd.sh" +force_install_dir "${STEAMAPPDIR}" \
    +login anonymous \
    +app_update "${STEAMAPPID}" validate \
    +quit

# Copy the entry point file
COPY --chown=${USER}:${USER} scripts/entry.sh /server/scripts/entry.sh
RUN chmod 550 /server/scripts/entry.sh

# Create required folders to keep their permissions on mount
RUN mkdir -p "${HOMEDIR}/smalland"

WORKDIR ${HOMEDIR}

# Expose ports
EXPOSE 7777/udp

ENTRYPOINT ["/server/scripts/entry.sh"]