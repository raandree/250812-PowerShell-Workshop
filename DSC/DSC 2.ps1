#Install-WindowsFeature -Name Print-Server

configuration BaseOs {

    #param (
    #    [Parameter(Mandatory)]
    #    [string[]]$ComputerName
    #)

    Import-DscResource -ModuleName NetworkingDsc

    node $ConfigurationData.AllNodes.NodeName {
        WindowsFeature PrintServer {
            Name = 'Print-Server'
            Ensure = 'Present'
        }

        File TestFile1 {
            DestinationPath = 'C:\TestFile1.txt'
            Contents = '123'
            Type = 'File'
        }

        File TestFile2 {
            DestinationPath = 'C:\TestFile2.txt'
            Contents = '123'
            Type = 'File'
        }

        IPAddress ip {
            IPAddress = $ConfigurationData."$NodeName".Network.IpAddress
            InterfaceAlias = 'DscWorkshop 0'
            AddressFamily = 'IPv4'
        }

        DnsServerAddress dns {
            InterfaceAlias = 'DscWorkshop 0'
            AddressFamily = 'IPv4'
            Address = '192.168.111.10'
        }

        DefaultGatewayAddress gw {
            InterfaceAlias = 'DscWorkshop 0'
            AddressFamily = 'IPv4'
            Address = '192.168.111.50'
        }
    }
}

$configData = @{
    AllNodes = @(
        @{
            NodeName = 'DSCHost01'
        }
        @{
            NodeName = 'DSCFile01'
        }
    )
    'DSCHost01' = @{
        Network = @{
            IpAddress = '192.168.111.80'
        }
    }
    'DSCFile01' = @{
        Network = @{
            IpAddress = '192.168.111.100'
        }
    }
}

BaseOs -OutputPath C:\DSC -ConfigurationData $configData

Start-DscConfiguration -Path C:\DSC -Wait -Verbose