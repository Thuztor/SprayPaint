require "Conf/sprayCanConf"

for _,v in ipairs(sprayCanConf.list); do
	table.insert(SuburbsDistributions["all"]["crate"].items, "spraypaint."..v.name);
	table.insert(SuburbsDistributions["all"]["crate"].items, 0.01);
	table.insert(SuburbsDistributions["all"]["metal_shelves"].items, "spraypaint."..v.name);
	table.insert(SuburbsDistributions["all"]["metal_shelves"].items, 0.01);
	table.insert(SuburbsDistributions["garagestorage"]["all"].items, "spraypaint."..v.name);
	table.insert(SuburbsDistributions["garagestorage"]["all"].items, 0.01);
end

for _,v in ipairs(sprayCanConf.listChalk); do
	table.insert(SuburbsDistributions["all"]["counter"].items, "spraypaint."..v.name);
	table.insert(SuburbsDistributions["all"]["counter"].items, 0.01);
	table.insert(SuburbsDistributions["all"]["wardrobe"].items, "spraypaint."..v.name);
	table.insert(SuburbsDistributions["all"]["wardrobe"].items, 0.01);
	table.insert(SuburbsDistributions["all"]["sidetable"].items, "spraypaint."..v.name);
	table.insert(SuburbsDistributions["all"]["sidetable"].items, 0.01);
	table.insert(SuburbsDistributions["all"]["bin"].items, "spraypaint."..v.name);
	table.insert(SuburbsDistributions["all"]["bin"].items, 0.01);
	table.insert(SuburbsDistributions["all"]["other"].items, "spraypaint."..v.name);
	table.insert(SuburbsDistributions["all"]["other"].items, 0.01);
end
