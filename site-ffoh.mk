GLUON_FEATURES := \
	autoupdater \
	ebtables-filter-multicast \
	ebtables-filter-ra-dhcp \
	ebtables-limit-arp \
	mesh-batman-adv-15 \
	mesh-vpn-fastd \
	radvd \
	respondd \
	status-page \
	web-advanced \
	web-wizard

GLUON_SITE_PACKAGES := \
	gluon-alfred \
	respondd-module-airtime \
	haveged \
	gluon-status-page-mesh-batman-adv \
	iwinfo
	#gluon-mesh-vpn-tunneldigger \

GLUON_DATE ?= $(shell date '+%Y%m%d')

DEFAULT_GLUON_RELEASE := 0.9.13~exp$(GLUON_DATE)

# Allow overriding the release number from the command line
GLUON_RELEASE ?= $(DEFAULT_GLUON_RELEASE)

GLUON_PRIORITY ?= 0

GLUON_LANGS ?= en de

GLUON_REGION=eu
GLUON_BRANCH=experimental
GLUON_ATH10K_MESH=11s
GLUON_WLAN_MESH=$(GLUON_ATH10K_MESH)
