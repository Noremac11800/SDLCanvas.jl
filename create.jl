using PkgTemplates

t = Template(;
           user="cam",
           authors=["Cameron Kirk"],
           plugins=[
               License(name="MIT"),
               Git(),
               GitHubActions(),
           ],
       )

t("JLGame")
