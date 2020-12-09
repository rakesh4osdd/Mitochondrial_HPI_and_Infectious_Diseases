#!/usr/bin/env python

# This is an automatically generated script to run your query
# to use it you will require the intermine python client.
# To install the client, run the following command from a terminal:
#
#     sudo easy_install intermine
#
# For further documentation you can visit:
#     http://intermine.readthedocs.org/en/latest/web-services/

# The following two lines will be needed in every python script:
from intermine.webservice import Service
service = Service("http://mitominer.mrc-mbu.cam.ac.uk:443/release-4.0/service")

# Get a new query on the class (table) you will be querying:
query = service.new_query("Protein")

# The view specifies the output columns
query.add_view(
    "primaryIdentifier", "primaryAccession", "name", "organism.shortName",
    "MTSipsort", "MTStargetP", "MTStargetPconfidence", "MTSmitoprot",
    "MTSmitoprotCleavage", "MTSmitofates", "MTSmitofatesCleavage",
    "uniprotAccession"
)

# Uncomment and edit the line below (the default) to select a custom sort order:
# query.add_sort_order("Protein.primaryIdentifier", "ASC")

# You can edit the constraint values below
query.add_constraint("organism.name", "=", "Homo sapiens", code = "A")

# Uncomment and edit the code below to specify your own custom logic:
# query.set_logic("A")

for row in query.rows():
    print row["primaryIdentifier"], row["primaryAccession"], row["name"], row["organism.shortName"], \
        row["MTSipsort"], row["MTStargetP"], row["MTStargetPconfidence"], row["MTSmitoprot"], \
        row["MTSmitoprotCleavage"], row["MTSmitofates"], row["MTSmitofatesCleavage"], \
        row["uniprotAccession"]

