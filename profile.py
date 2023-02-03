import geni.portal as portal
import geni.rspec.pg as pg
import geni.rspec.igext as IG

pc = portal.Context()
request = pc.makeRequestRSpec()

tourDescription = \
"""
This profile provides a single RawPC Docker node. 
"""

tour = IG.Tour()
tour.Description(IG.Tour.TEXT,tourDescription)
request.addTour(tour)

node = request.RawPC("head")  
node.routable_control_ip = "true" 
bs_landing = node.Blockstore("bs_image", "/image")
bs_landing.size = "200GB"
node.disk_image = "urn:publicid:IDN+emulab.net+image+emulab-ops:UBUNTU20-64-STD"
node.addService(pg.Execute(shell="sh", command="sudo bash /local/repository/install_docker.sh"))
    
pc.printRequestRSpec(request)
