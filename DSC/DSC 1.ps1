#Install-WindowsFeature -Name Print-Server

configuration BaseOs {

    Import-DscResource -ModuleName NetworkingDsc

    WindowsFeature PrintServer {
        Name = 'Print-Server'
        Ensure = 'Present'
    }

    File TestFile1 {
        DestinationPath = 'C:\TestFile1.txt'
        Contents = '123'
        Type = 'File'
    }

    IPAddress ip {
        IPAddress = '192.168.111.80'
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

BaseOs -OutputPath C:\DSC

Start-DscConfiguration -Path C:\DSC -Wait -Verbose