import logging
import time
import jinja2
import json
import re
import os
import shutil


def load_json_mods_list():
    with open("./inputs/mods.json", "rt") as mods_file:
        content = json.loads(mods_file.read())
        return content["data"]["mods"]["items"]

    return None


key_manifest = dict()


def key_valuator(value):
    if value == "turbot":
        key_manifest["turbot"] = 1
    elif value == "turbot-iam":
        key_manifest["turbot-iam"] = 2
    elif value == "aws":
        key_manifest["aws"] = 3
    elif value == "aws-iam":
        key_manifest["aws-iam"] = 3
    else:
        total = len(key_manifest)
        key_manifest[value] = total + 4

    return key_manifest[value]


def organise_mod_list(source_mod_items):
    mod_list = []
    for source_mod_item in source_mod_items:
        mod_id = source_mod_item["modId"]

        result = re.match(r"tmod:@turbot\/(.*)", mod_id)
        if result is None:
            logging.error("Unknown mod type - IGNORING")
            continue

        mod_name = result[1]
        if mod_name in ["windows", "windows-playbook", "linux", "linux-playbook"]:
            logging.warning(f"Ignoring Custom Mod {mod_name}")
            continue

        split_mod_name = mod_name.split("-")
        safe_mod_name = "_".join(split_mod_name)

        item = {
            "mod_name": mod_name,
            "safe_mod_name": safe_mod_name
        }

        mod_list.append(item)

    mod_list.sort(key=lambda mod_item: key_valuator(mod_item["mod_name"]))

    # enrich
    previous_safe_mod_name = None
    previous_mod_name = None
    for sorted_item in mod_list:
        if previous_safe_mod_name:
            sorted_item["safe_depends_on"] = previous_safe_mod_name

        if previous_mod_name:
            sorted_item["depends_on"] = previous_mod_name

        previous_mod_name = sorted_item["mod_name"]
        previous_safe_mod_name = sorted_item["safe_mod_name"]

    return mod_list


def organise_mod_list_old(source_mod_items):
    mod_list = []
    depends_on = None
    safe_depends_on = None
    for source_mod_item in source_mod_items:
        mod_id = source_mod_item["modId"]

        result = re.match(r"tmod:@turbot\/(.*)", mod_id)
        if result is None:
            logging.error("Unknown mod type - IGNORING")
            continue

        mod_name = result[1]
        split_mod_name = mod_name.split("-")
        safe_mod_name = "_".join(split_mod_name)

        if depends_on is None:
            item = {
                "mod_name": mod_name,
                "safe_mod_name": safe_mod_name
            }
        else:
            item = {
                "depends_on": depends_on,
                "safe_depends_on": safe_depends_on,
                "mod_name": mod_name,
                "safe_mod_name": safe_mod_name
            }

        mod_list.append(item)

        depends_on = mod_name
        safe_depends_on = safe_mod_name

    return mod_list


def main():
    source_mod_items = load_json_mods_list()
    mod_list = organise_mod_list(source_mod_items)
    duration = 5 * 60

    if not os.path.isdir("./results"):
        os.mkdir("./results")

    with open("./templates/mods.j2", "r") as template_file:
        mods_template_file = jinja2.Template(template_file.read())
    mods_output = mods_template_file.render(mod_list=mod_list, duration=duration)
    with open("./results/mods.tf", "wt") as output_file:
        output_file.write(mods_output)

    with open("./templates/variables.j2", "r") as template_file:
        variables_template_file = jinja2.Template(template_file.read())
    variables_output = variables_template_file.render(duration=duration)
    with open("./results/variables.tf", "wt") as output_file:
        output_file.write(variables_output)

    shutil.copy("./templates/providers.tf", "./results/providers.tf")
    shutil.copy("./templates/README.md", "./results/README.md")


if __name__ == "__main__":
    logging.basicConfig(
        level=logging.INFO,
        format='%(asctime)s %(levelname)s %(message)s'
    )

    start = time.perf_counter()
    logging.info(f"Started Generate")

    main()

    end = time.perf_counter()
    logging.info(f"Completed Generate: {round(end - start, 2)} seconds")
