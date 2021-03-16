# Deadline Test Lab

Deadline, but dockerized!

## Rationale

This is mostly for testing and evaluation purposes. It has all the major components for Deadline to function

* MongoDB
* Repository installer
* Remote Connection Server (RCS)
* Web Service

There is no security of any description, no protection on the database, no tls on the client connection etc.

## Getting Started

You will need to download the linux installers from the [Thinkbok website](https://downloads.thinkboxsoftware.com). They are not included here.

Extract the installers and place the `DeadlineClient-10.*.*.*-linux-x64-installer.run` in the `client` directory and `DeadlineRepository-*.*.*.*-linux-x64-installer.run` in the `repository` directory.

The whole stack can be spun up with:

```
docker-compose up -d
```

Once the database is up and the repository is installed, the RCS will be available on port `8080` and the webservice will be available on port `8085`.

The repository container will exit successully when the installer finishes. At that point its job is done.

## Configuration

### Basic

The current configuration is completely ephemeral by design. `docker-compose down -v` will wipe the whole thing.

You may want to persist the database and / or the repository to disk, or connect the RCS / Webservice to an existing repository. In this case you'll want to change the volume mounts to bind mounts:

```yml

    volumes:
      - type: volume
        source: repo
        target: /repo

```

becomes:

```yml

    volumes:
      - type: bind
        source: /path/to/repo
        target: /repo

```

### Repository

All the repository install [commandline options](https://docs.thinkboxsoftware.com/products/deadline/10.0/1_User%20Manual/manual/install-db-repo.html#command-line-or-silent-installation) can provided as environment variables.

Prefix the option with `dl_`, for example:

```
./DeadlineRepository-10.1.14.4-linux-x64-installer.run \
    --prefix /repo \
    --mode unattended \
    --debuglevel 4
```

Is expressed as:

```yml

    environment:
      dl_prefix: "/repo"
      dl_mode: "unattended"
      dl_debuglevel: "4"

```

### Client

On Linux, the Deadline clients pull their configuration from `/var/lib/Thinkbox/Deadline10/deadline.ini`, this is normally configured when the client is installed. The Dockerfile provided only installs the binaries and the `deadline.ini` file is created when the container starts. As with the repository, prefix the configuration option with `dl_`.

```ini

[Deadline]
LicenseMode=Free
LicenseServer=
Region=
LauncherListeningPort=17000
LauncherServiceStartupDelay=60
AutoConfigurationPort=17001
SlaveStartupPort=17003
SlaveDataRoot=
RestartStalledSlave=false
NoGuiMode=true
LaunchSlaveAtStartup=false
AutoUpdateOverride=
ConnectionType=Repository
NetworkRoot=/repo
DbSSLCertificate=

```

Becomes:

```yml

    environment:
      dl_LicenseMode: "Free"
      dl_LicenseServer: ""
      dl_Region: ""
      dl_LauncherListeningPort: "17000"
      dl_LauncherServiceStartupDelay: "60"
      dl_AutoConfigurationPort: "17001"
      dl_SlaveStartupPort: "17003"
      dl_SlaveDataRoot: ""
      dl_RestartStalledSlave: "false"
      dl_NoGuiMode: "true"
      dl_LaunchSlaveAtStartup: "false"
      dl_AutoUpdateOverride: ""
      dl_ConnectionType: "Repository"
      dl_NetworkRoot: "/repo"
      dl_DbSSLCertificate: ""

```


