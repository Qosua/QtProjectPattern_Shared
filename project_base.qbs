import qbs
import "qbs/imports/QbsUtl/qbsutl.js" as QbsUtl

Project
{
    minimumQbsVersion: "1.19.0"
    qbsSearchPaths: ["qbs"]

    Probe
    {
        id: projectInfo

        property var projectVersion;
        property string projectGitRevision;

        readonly property string projectBuildDirectory:  project.buildDirectory
        readonly property string projectSourceDirectory: project.sourceDirectory

        configure:
        {
            projectVersion = QbsUtl.getVersions(projectSourceDirectory + "/VERSION");
            projectGitRevision = QbsUtl.gitRevision(projectSourceDirectory);
        }
    }

    readonly property var projectVersion: projectInfo.projectVersion
    readonly property string projectGitRevision: projectInfo.projectGitRevision

    property var cppDefines:
    {
        var def = [
            "VERSION_PROJECT=\"" + projectVersion[0] + "\"",
            "VERSION_PROJECT_MAJOR=" + projectVersion[1],
            "VERSION_PROJECT_MINOR=" + projectVersion[2],
            "VERSION_PROJECT_PATCH=" + projectVersion[3],
            "GIT_REVISION=\"" + projectGitRevision + "\"",
            "QDATASTREAM_VERSION=QDataStream::Qt_5_12",
//            "QDATASTREAM_BYTEORDER=QDataStream::LittleEndian",
//            "PPROTO_VERSION_LOW=0",
//            "PPROTO_VERSION_HIGH=0",
//            "PPROTO_JSON_SERIALIZE",
//            "PPROTO_QBINARY_SERIALIZE",
//            "PPROTO_UDP_SIGNATURE=\"PPDM\"",
        ];

        if (qbs.targetOS.contains("windows")
            && qbs.toolchain && qbs.toolchain.contains("mingw"))
            def.push("CONFIG_DIR=\"AppData/Roaming/<project name>\"");
        else
            // def.push("CONFIG_DIR=\"/etc/<project name>\"");
            def.push("CONFIG_DIR=\"~/.config/<project name>\"");

        return def;
    }
    property string cxxLanguageVersion: "c++17"

    property var cxxFlags: [
        "-ggdb3",
        "-Wall",
        "-Wextra",
        "-Wno-unused-parameter",
        "-Wno-variadic-macros",
        "-Wno-register",
    ]


}
