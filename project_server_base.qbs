import qbs
import "project_base.qbs" as ProjectBase

ProjectBase
{
    name: "Project (Server)"

    references:[
        "src/project_server/project_server.qbs",
        "src/shared/shared.qbs",
        "src/yaml/yaml.qbs",
    ]
}
