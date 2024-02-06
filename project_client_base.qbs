import qbs
import "project_base.qbs" as ProjectBase

ProjectBase
{
    name: "Project (Client)"

    references:[
        "src/project_client/project_client.qbs",
        "src/shared/shared.qbs",
        "src/yaml/yaml.qbs",
    ]
}
